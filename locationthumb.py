# Script needs to be pasted in QGIS, see README for instructions.

from qgis.core import (
    QgsCoordinateReferenceSystem,
    QgsCoordinateTransform,
    QgsMapRendererParallelJob,
    QgsMapSettings,
    QgsRasterLayer,
    QgsRectangle,
    QgsProcessingAlgorithm,
    QgsProcessingParameterNumber,
    QgsProcessingParameterFileDestination,
    QgsPointXY
)
from qgis.PyQt.QtCore import QPointF, QSize
from qgis.PyQt.QtGui import QColor, QPainter, QPen

class GenerateMapAlgorithm(QgsProcessingAlgorithm):
    """Creates a thumbnail with a dot in the middle for a given latitude & longitude."""

    def createInstance(self):
        return GenerateMapAlgorithm()

    def name(self):
        return 'locationthumb'

    def displayName(self):
        return 'Location Thumbnail'

    def initAlgorithm(self, config=None):
        self.addParameter(
            QgsProcessingParameterNumber(
                'CENTER_LAT',
                'Map Center Latitude',
                QgsProcessingParameterNumber.Double,
                defaultValue=0
            )
        )

        self.addParameter(
            QgsProcessingParameterNumber(
                'CENTER_LNG',
                'Map Center Longitude',
                QgsProcessingParameterNumber.Double,
                defaultValue=0
            )
        )

        self.addParameter(
            QgsProcessingParameterNumber(
                'AREA_WIDTH',
                'Map Area (in KM)',
                defaultValue=300
            )
        )

        self.addParameter(
            QgsProcessingParameterFileDestination(
                'OUT',
                'Output Image',
                'PNG image',
                defaultValue='thumb.png'
            )
        )

    def processAlgorithm(self, parameters, context, feedback):
        lat = self.parameterAsDouble(parameters, 'CENTER_LAT', context)
        lng = self.parameterAsDouble(parameters, 'CENTER_LNG', context)
        area_width = self.parameterAsInt(parameters, 'AREA_WIDTH', context) * 1000 # in meter
        output_file = self.parameterAsFileOutput(parameters, 'OUT', context)

        IMG_SIZE = QSize(200, 200)
        BLUE = QColor('#0367d8')
        WHITE = QColor('white')

        def mapLayer():
            layer_name = 'Esri_WorldTerrain'
            url = 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}'
            conn_string = f"type=xyz&url={url}"
            return QgsRasterLayer(conn_string, layer_name, 'wms')

        def centerPt():
            crs_src = QgsCoordinateReferenceSystem("EPSG:4326")
            crs_dest = QgsCoordinateReferenceSystem("EPSG:3857")
            transformer = QgsCoordinateTransform(crs_src, crs_dest, context.project())
            return transformer.transform(QgsPointXY(lng, lat))

        def drawDot():
            painter = QPainter(img)
            painter.setPen(QPen(WHITE, 2))
            painter.setBrush(BLUE)
            center_pt = QPointF(IMG_SIZE.width() / 2, IMG_SIZE.height() / 2)
            radius = 5
            painter.drawEllipse(center_pt, radius, radius)
            painter.end()

        layer = mapLayer()
        map_settings = QgsMapSettings()
        map_settings.setLayers([layer])
        map_settings.setBackgroundColor(WHITE)
        map_settings.setOutputSize(IMG_SIZE)
        center_pt = centerPt()
        extent = QgsRectangle(
            center_pt.x() - area_width,
            center_pt.y() - area_width,
            center_pt.x() + area_width,
            center_pt.y() + area_width
        )
        map_settings.setExtent(extent)

        job = QgsMapRendererParallelJob(map_settings)
        job.start()
        job.waitForFinished()
        img = job.renderedImage()

        drawDot()

        img.save(output_file, 'PNG')
        return {'OUT': output_file}

#!/usr/bin/python3.2
from PySide import QtGui
import sys

from audio.audio_server import AudioServer
from audio.transform import PositionToAudioTransformer
from audio.tuning_parameters import TuningParameters
from calibrate import shape_generators
from calibrate.mainwindow import MainWindow
from calibrate.plane_2d_to_3d_adapter import Plane2dTo3dAdapter
from calibrate.transformer_proxy import PositionToAudioTransformerProxy

SAMPLING_RATE = 8000

app = QtGui.QApplication(sys.argv)
widget = QtGui.QMainWindow()
generator = shape_generators.NullGenerator(SAMPLING_RATE, 1.0) # Just to make sure we don't leave it in an invalid state
height_adapter = Plane2dTo3dAdapter(generator, 0.0)
tuning = TuningParameters()
transformer = PositionToAudioTransformer(tuning)
transformer_proxy = PositionToAudioTransformerProxy(transformer, height_adapter)
audio = AudioServer(transformer_proxy, SAMPLING_RATE)
generators = {'Square': shape_generators.SquareGenerator,
              'Star': shape_generators.StarGenerator}
ui = MainWindow(tuning, audio, transformer_proxy, generators, height_adapter, SAMPLING_RATE)
ui.setupUi(widget)
widget.show()
audio.start()
retcode = app.exec_()
audio.stop()
sys.exit(retcode)

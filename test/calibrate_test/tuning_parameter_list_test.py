import unittest
import sys
import os

from calibrate.mainwindow import TuningParameterListModel
from audio.tuning_parameters import TuningParameters, TuningParameterCollection

class TuningParameterListModelTest(unittest.TestCase):
    def test_adding_identical_heights_fails(self):
        tuning_parameters_collection = TuningParameterCollection()
        height = 1.0
        tuning_parameter_list_model = TuningParameterListModel(tuning_parameters_collection)
        tuning_parameter = tuning_parameters_collection.get_tuning_parameters_for_height(height)
        tuning_parameter_list_model.addRow(tuning_parameter)

        tuning_parameter_list_model.addRow(tuning_parameter)

        self.assertEquals(1, tuning_parameter_list_model.rowCount())
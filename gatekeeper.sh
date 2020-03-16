#!/bin/bash -eu

cpp/katago gatekeeper -rejected-models-dir shared/rejectedmodels -accepted-models-dir shared/models -sgf-output-dir shared/gatekeepersgf -test-models-dir shared/modelstobetested -config-file cpp/configs/gatekeeper1.cfg
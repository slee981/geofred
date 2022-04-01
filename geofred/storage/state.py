import os
import pandas as pd

from geofred.utils import build_map

state_fname = "state.csv"

this_dir = os.path.dirname(os.path.realpath(__file__))
state_fpath = os.path.join(this_dir, state_fname)

DF_STATE = pd.read_csv(state_fpath)


def build_state_map():
    return build_map(DF_STATE, ["State", "Abvr"])


STATE_MAP = build_state_map()

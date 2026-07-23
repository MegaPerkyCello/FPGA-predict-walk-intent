# 2026-07-21T23:43:38.414739900
import vitis

client = vitis.create_client()
client.set_workspace(path="LSTM")

comp = client.create_hls_component(name = "conv1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

vitis.dispose()


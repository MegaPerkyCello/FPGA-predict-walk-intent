# 2026-07-20T12:52:49.262487700
import vitis

client = vitis.create_client()
client.set_workspace(path="LSTM")

comp = client.create_hls_component(name = "LSTM",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

vitis.dispose()


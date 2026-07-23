# 2026-07-22T21:31:33.922705
import vitis

client = vitis.create_client()
client.set_workspace(path="workspace")

comp = client.get_component(name="Relu_Max_1")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.create_hls_component(name = "Relu_Max_2",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="conv2")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp = client.get_component(name="conv1")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp = client.get_component(name="conv2")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.get_component(name="Relu_Max_1")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.get_component(name="LSTM")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.get_component(name="Relu_Max_2")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

vitis.dispose()


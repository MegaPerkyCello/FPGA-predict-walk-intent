# 2026-07-23T10:09:07.314726800
import vitis

client = vitis.create_client()
client.set_workspace(path="workspace")

comp = client.get_component(name="conv1")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")


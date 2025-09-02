extends Node

# Gear Simulator
# Purpose: to simulate
# - abstract mechanical chains
# - gear trains
# - contraptions with multiple independent trains
# - robot arms
# - peg logic
#
# Entities:
#  WorkspaceItem
#   |
#   ContraptionPart
#    |
#    +PrimitiveCPart
#    | |
#    | Gear
#    | Motor
#    | Arm
#    | etc
#    +ConstraintCPart
#    | |
#    | Link
#    | Belt
#    | Offset
#    +HierarchicalCPart
#   UIItem
#    |
#    Selection
#    Tooltip
#    Marker
#    Panel
#    Indicator
#    Control

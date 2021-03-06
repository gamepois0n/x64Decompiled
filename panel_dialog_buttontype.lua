local dialogQuestButtonIcon = {
  [0] = {
    380,
    31,
    398,
    50
  },
  {
    475,
    1,
    493,
    20
  },
  {
    380,
    11,
    398,
    30
  },
  {
    418,
    1,
    436,
    20
  },
  {
    437,
    1,
    455,
    20
  },
  {
    456,
    1,
    474,
    20
  },
  {
    399,
    1,
    417,
    20
  },
  {
    380,
    11,
    398,
    30
  },
  {
    399,
    21,
    417,
    40
  },
  {
    456,
    21,
    474,
    40
  }
}
local dialogButtonIcon = {
  [0] = {
    0,
    0,
    0,
    0
  },
  {
    494,
    41,
    512,
    59
  },
  {
    475,
    41,
    493,
    60
  },
  {
    418,
    21,
    436,
    40
  },
  {
    494,
    21,
    512,
    40
  },
  {
    494,
    21,
    512,
    40
  }
}
function FGlobal_ChangeOnTextureForDialogQuestIcon(control, iconType)
  control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, dialogQuestButtonIcon[iconType][1], dialogQuestButtonIcon[iconType][2], dialogQuestButtonIcon[iconType][3], dialogQuestButtonIcon[iconType][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function FGlobal_ChangeOnTextureForDialogIcon(control, iconType)
  control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, dialogButtonIcon[iconType][1], dialogButtonIcon[iconType][2], dialogButtonIcon[iconType][3], dialogButtonIcon[iconType][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end

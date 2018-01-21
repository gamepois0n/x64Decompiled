local UI_TM = CppEnums.TextMode
local VCK = CppEnums.VirtualKeyCode
local UI_color = Defines.Color
local UI_classType = CppEnums.ClassType
local IM = CppEnums.EProcessorInputMode
PaGlobal_ArousalTutorial_Manager = {_isDoingArousalTutorial = false}
local _stepNo = 0
local _updateTime = 0
local classType
local function get_ClassType()
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    classType = selfPlayer:getClassType()
  end
end
get_ClassType()
Panel_ArousalTutorial:RegisterUpdateFunc("FGlobal_ArousalTutorial_UpdatePerFrame")
function FGlobal_ArousalTutorial_UpdatePerFrame(deltaTime)
  PaGlobal_ArousalTutorial_Manager:updatePerFrame(deltaTime)
end
function PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial()
  return self._isDoingArousalTutorial
end
function PaGlobal_ArousalTutorial_Manager:setDoingArousalTutorial(bDoing)
  self._isDoingArousalTutorial = bDoing
end
function PaGlobal_ArousalTutorial_Manager:endTutorial()
  PaGlobal_ArousalTutorial_UiManager:hideAllTutorialUi()
  Panel_ArousalTutorial:SetShow(false, true)
  PaGlobal_ArousalTutorial_Manager:setDoingArousalTutorial(false)
end
local hasGuildQuest = ToClient_isProgressingGuildQuest()
function PaGlobal_ArousalTutorial_Manager:getStringResize(string1, string2, stringType)
  local stringSizeY = 0
  if 1 == stringType then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetText(string1)
    stringSizeY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:GetTextSizeY()
  elseif 2 == stringType then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetText(string1)
    stringSizeY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:GetTextSizeY()
  elseif 3 == stringType then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetText(string1)
    stringSizeY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:GetTextSizeY()
  elseif 4 == stringType then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetText(string1)
    stringSizeY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetTextSizeY()
  end
  local stringSet = string1 .. "\n" .. string2
  if stringSizeY > 20 then
    stringSet = string1 .. string2
  else
    stringSet = string1 .. "\n" .. string2
  end
  return stringSet
end
local baseComboCount = 4
local usedSkillKey = {}
local usedSkillMatch = {}
for index = 0, baseComboCount - 1 do
  usedSkillKey[index] = nil
  usedSkillMatch[index] = false
end
local SkillComboCheck = {
  [UI_classType.ClassType_Warrior] = {
    [0] = {
      [0] = {
        349,
        350,
        351,
        705,
        2847
      },
      {
        349,
        350,
        351,
        705,
        2847
      },
      {1712}
    },
    [1] = {
      [0] = {385, 2848},
      {1712},
      {
        1765,
        1766,
        1767,
        1768
      }
    }
  },
  [UI_classType.ClassType_Ranger] = {
    [0] = {
      [0] = {
        1006,
        1091,
        1092,
        1093,
        375,
        1102,
        2855
      },
      {1855}
    },
    [1] = {
      [0] = {
        1029,
        1119,
        1250,
        1251,
        2864
      },
      {1855},
      {
        1875,
        1876,
        1877,
        1878
      }
    }
  },
  [UI_classType.ClassType_Sorcerer] = {
    [0] = {
      [0] = {
        1056,
        1202,
        1203,
        583,
        2876
      },
      {1769}
    },
    [1] = {
      [0] = {
        1056,
        1202,
        1203,
        583,
        2876
      },
      {1769},
      {
        1785,
        1786,
        1787,
        1788
      }
    }
  },
  [UI_classType.ClassType_Giant] = {
    [0] = {
      [0] = {
        1041,
        1163,
        1164,
        1165,
        1166,
        296,
        2895
      },
      {1812}
    },
    [1] = {
      [0] = {
        1042,
        1167,
        1168,
        1169,
        1170,
        1171,
        2896
      },
      {1812},
      {
        1830,
        1831,
        1832,
        1833
      }
    }
  },
  [UI_classType.ClassType_Tamer] = {
    [0] = {
      [0] = {
        1070,
        1232,
        1233,
        1234,
        2926
      },
      {1898}
    },
    [1] = {
      [0] = {
        129,
        130,
        131,
        132,
        205,
        2930
      },
      {1898},
      {
        1913,
        1914,
        1915,
        1916
      }
    }
  },
  [UI_classType.ClassType_BladeMaster] = {
    [0] = {
      [0] = {
        1445,
        1446,
        1447,
        3169
      },
      {1986}
    },
    [1] = {
      [0] = {
        1263,
        1264,
        1265,
        418,
        3154
      },
      {1986},
      {
        2000,
        2001,
        2002,
        2003
      }
    }
  },
  [UI_classType.ClassType_BladeMasterWomen] = {
    [0] = {
      [0] = {
        1549,
        1550,
        1551,
        1552,
        1553,
        3184
      },
      {2029}
    },
    [1] = {
      [0] = {
        1515,
        1516,
        1517,
        1518,
        1520,
        3176
      },
      {2029},
      {
        2040,
        2041,
        2042,
        2043
      }
    }
  },
  [UI_classType.ClassType_Valkyrie] = {
    [0] = {
      [0] = {
        732,
        733,
        734,
        735,
        770,
        3202
      },
      {1943}
    },
    [1] = {
      [0] = {
        1497,
        1498,
        1499,
        3203
      },
      {1943},
      {
        1963,
        1964,
        1965,
        1966
      }
    }
  },
  [UI_classType.ClassType_Wizard] = {
    [0] = {
      [0] = {
        822,
        823,
        824,
        825,
        826,
        3133
      },
      {2209}
    },
    [1] = {
      [0] = {
        834,
        835,
        836,
        837,
        838,
        3137
      },
      {2209},
      {
        2225,
        2226,
        2227,
        2228
      }
    }
  },
  [UI_classType.ClassType_WizardWomen] = {
    [0] = {
      [0] = {
        822,
        823,
        824,
        825,
        826,
        3133
      },
      {2163}
    },
    [1] = {
      [0] = {
        834,
        835,
        836,
        837,
        838,
        3137
      },
      {2163},
      {
        2186,
        2187,
        2188,
        2189
      }
    }
  },
  [UI_classType.ClassType_NinjaMan] = {
    [0] = {
      [0] = {
        962,
        963,
        964,
        965,
        3111
      },
      {2077}
    },
    [1] = {
      [0] = {
        966,
        967,
        968,
        969,
        970,
        3112
      },
      {2077},
      {
        2104,
        2105,
        2106,
        2107
      }
    }
  },
  [UI_classType.ClassType_NinjaWomen] = {
    [0] = {
      [0] = {
        962,
        963,
        964,
        965,
        3111
      },
      {2120}
    },
    [1] = {
      [0] = {
        966,
        967,
        968,
        969,
        970,
        3112
      },
      {2120},
      {
        2154,
        2155,
        2156,
        2157
      }
    }
  },
  [UI_classType.ClassType_DarkElf] = {
    [0] = {
      [0] = {
        2268,
        2340,
        2363,
        2341,
        3075
      },
      {2380}
    },
    [1] = {
      [0] = {
        2269,
        2270,
        2271,
        2272,
        2273,
        3089
      },
      {2380},
      {
        2391,
        2392,
        2393,
        2394
      }
    }
  },
  [UI_classType.ClassType_Combattant] = {
    [0] = {
      [0] = {
        2486,
        2487,
        2488,
        2489,
        3038
      },
      {2558}
    },
    [1] = {
      [0] = {
        2486,
        2487,
        2488,
        2489,
        3038
      },
      {2558},
      {
        2562,
        2563,
        2564,
        2565
      }
    }
  },
  [UI_classType.ClassType_CombattantWomen] = {
    [0] = {
      [0] = {
        2674,
        2675,
        2676,
        2677,
        3062
      },
      {2762}
    },
    [1] = {
      [0] = {
        2691,
        2692,
        2693,
        3064
      },
      {2762},
      {
        2776,
        2777,
        2778,
        2779
      }
    }
  }
}
local questCheck = {
  [UI_classType.ClassType_Warrior] = {
    [0] = {
      questGroup = 285,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 285,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_ComboKey_2")
      }
    }
  },
  [UI_classType.ClassType_Ranger] = {
    [0] = {
      questGroup = 293,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 293,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_Sorcerer] = {
    [0] = {
      questGroup = 287,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 287,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_1")
      }
    }
  },
  [UI_classType.ClassType_Giant] = {
    [0] = {
      questGroup = 290,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 290,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_Tamer] = {
    [0] = {
      questGroup = 296,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 296,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_BladeMaster] = {
    [0] = {
      questGroup = 319,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 319,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_BladeMasterWomen] = {
    [0] = {
      questGroup = 321,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 321,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_Valkyrie] = {
    [0] = {
      questGroup = 298,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 298,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_Wizard] = {
    [0] = {
      questGroup = 336,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_PURPOSETEXT_0_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_0_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_0_1")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_0_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_0_1")
      }
    },
    [1] = {
      questGroup = 336,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_PURPOSETEXT_1_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_1_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_1_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_1_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_1_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_1_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_1_2")
      }
    }
  },
  [UI_classType.ClassType_WizardWomen] = {
    [0] = {
      questGroup = 334,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_PURPOSETEXT_0_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_0_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_0_1")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_0_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_0_1")
      }
    },
    [1] = {
      questGroup = 334,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_PURPOSETEXT_1_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_1_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_1_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_1_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_1_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_1_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_1_2")
      }
    }
  },
  [UI_classType.ClassType_NinjaMan] = {
    [0] = {
      questGroup = 325,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 325,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_NinjaWomen] = {
    [0] = {
      questGroup = 327,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 327,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_DarkElf] = {
    [0] = {
      questGroup = 338,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 338,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_Combattant] = {
    [0] = {
      questGroup = 342,
      questId = 8,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 342,
      questId = 9,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_ComboKey_3")
      }
    }
  },
  [UI_classType.ClassType_CombattantWomen] = {
    [0] = {
      questGroup = 343,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_ComboKey_2")
      }
    },
    [1] = {
      questGroup = 343,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_ComboKey_3")
      }
    }
  }
}
function pushSkillKey(startIndex, endIndex)
  if startIndex == endIndex then
    return
  end
  if nil ~= usedSkillKey[startIndex] then
    pushSkillKey(startIndex + 1, endIndex)
  else
    return
  end
  usedSkillKey[startIndex + 1] = usedSkillKey[startIndex]
end
local progressQuestIndex = 0
local _ramainTime = 0
function compareSkillCombo(classType)
  progressQuestIndex = -1
  for index = 0, #questCheck[classType] do
    if questList_hasProgressQuest(questCheck[classType][index].questGroup, questCheck[classType][index].questId) then
      progressQuestIndex = index
      if not PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial() then
        PaGlobal_ArousalTutorial_Manager:startTutorial()
      end
    end
  end
  if -1 == progressQuestIndex then
    return
  end
  local comboSkillKey = SkillComboCheck[classType][progressQuestIndex]
  local matchCount = 0
  for index = #comboSkillKey, 0, -1 do
    for key, value in pairs(comboSkillKey[index]) do
      if value == usedSkillKey[matchCount] then
        matchCount = matchCount + 1
        _ramainTime = 0
      end
    end
  end
  if #comboSkillKey + 1 == matchCount then
    return true
  end
  return false
end
local comboQuestClear = false
function Tutorial_CheckUsedSkill(skillWrapper)
  if getSelfPlayer():get():getLevel() < 56 then
    return
  end
  if nil == SkillComboCheck[classType] then
    return
  end
  for index = 0, #questCheck[classType] do
    if questList_hasProgressQuest(questCheck[classType][index].questGroup, questCheck[classType][index].questId) then
      local uiQuestInfo = ToClient_GetQuestInfo(questCheck[classType][index].questGroup, questCheck[classType][index].questId)
      if nil == uiQuestInfo then
        _PA_ASSERT(false, "\234\179\181\236\161\180\237\149\160 \236\136\152 \236\151\134\235\138\148 \237\128\152\236\138\164\237\138\184\234\176\128 \234\179\181\236\161\180\237\149\180\236\132\156 \235\172\184\236\160\156\234\176\128 \236\131\157\234\178\188\236\138\181\235\139\136\235\139\164. \236\153\132\235\163\140\237\150\136\236\150\180\236\149\188 \237\149\152\235\138\148 \236\151\176\234\179\132\237\128\152\236\138\164\237\138\184\235\165\188 \236\150\181\236\167\128\235\161\156 \236\180\136\234\184\176\237\153\148\237\149\152\234\179\160 \235\139\164\236\139\156 \235\176\155\236\156\188\235\169\180 \236\157\180\235\159\180 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.")
        return
      end
      local questCondition = uiQuestInfo:getDemandAt(0)
      if questCondition._destCount <= questCondition._currentCount then
        return
      elseif not PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial() then
        PaGlobal_ArousalTutorial_Manager:startTutorial()
      end
    end
  end
  if comboQuestClear then
    return
  end
  pushSkillKey(0, baseComboCount)
  local skillWrapper = selfPlayerUsedSkillFront()
  if nil ~= skillWrapper then
    local skillNo = skillWrapper:getSkillNo()
    local skillName = skillWrapper:getName()
    usedSkillKey[0] = skillNo
    selfPlayerUsedSkillPopFront()
  end
  comboQuestClear = false
  if compareSkillCombo(classType) then
    request_clearMiniGame(questCheck[classType][progressQuestIndex].clearMinigameIndex)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:AddEffect("fUI_Gauge_BigWhite", false, 0, 0)
    comboQuestClear = true
  end
end
function ComboTutorial_NextStep_FontColorChange(index1, index2, index3, index4)
  if index1 then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:AddEffect("UI_Check01", false, -2, 0)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:AddEffect("fL_CheckSpark01", false, -2, 0)
  else
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetFontColor(UI_color.C_FFC4BEBE)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:EraseAllEffect()
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:SetShow(false)
  end
  if index2 then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:AddEffect("UI_Check01", false, -2, 0)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:AddEffect("fL_CheckSpark01", false, -2, 0)
  else
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetFontColor(UI_color.C_FFC4BEBE)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:EraseAllEffect()
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:SetShow(false)
  end
  if index3 then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:AddEffect("UI_Check01", false, -2, 0)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:AddEffect("fL_CheckSpark01", false, -2, 0)
  else
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetFontColor(UI_color.C_FFC4BEBE)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:EraseAllEffect()
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:SetShow(false)
  end
  if index4 then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:AddEffect("UI_Check01", false, -2, 0)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:AddEffect("fL_CheckSpark01", false, -2, 0)
  else
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetFontColor(UI_color.C_FFC4BEBE)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:EraseAllEffect()
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:SetShow(false)
  end
end
local function comboSuccess(comboSkillIndex, usedSkillIndex)
  local comboSkillKey = SkillComboCheck[classType][progressQuestIndex]
  if nil == comboSkillKey[comboSkillIndex] then
    return
  end
  for key, value in pairs(comboSkillKey[comboSkillIndex]) do
    if value == usedSkillKey[usedSkillIndex] then
      return true
    end
  end
  return false
end
local function comboCheck()
  if progressQuestIndex < 0 then
    return
  end
  if usedSkillMatch[3] then
    ComboTutorial_NextStep_FontColorChange(true, true, true, true)
  elseif usedSkillMatch[2] then
    ComboTutorial_NextStep_FontColorChange(true, true, true, false)
    if comboSuccess(3, 0) and comboSuccess(2, 1) then
      usedSkillMatch[3] = true
    end
  elseif usedSkillMatch[1] then
    ComboTutorial_NextStep_FontColorChange(true, true, false, false)
    if comboSuccess(2, 0) and comboSuccess(1, 1) then
      usedSkillMatch[2] = true
    end
  elseif usedSkillMatch[0] then
    ComboTutorial_NextStep_FontColorChange(true, false, false, false)
    if comboSuccess(1, 0) and comboSuccess(0, 1) then
      usedSkillMatch[1] = true
    end
  else
    ComboTutorial_NextStep_FontColorChange(false, false, false, false)
  end
  if comboSuccess(0, 0) then
    usedSkillMatch[0] = true
  end
end
local function updateDeltaTime_ComboTutorial(deltaTime)
  _ramainTime = _ramainTime + deltaTime
  comboCheck()
  if comboQuestClear and _ramainTime > 3 then
    _stepNo = 0
    PaGlobal_ArousalTutorial_Manager:endTutorial()
  end
  if not comboQuestClear and _ramainTime > 3 then
    _ramainTime = 0
    for index = 0, baseComboCount - 1 do
      usedSkillKey[index] = nil
      usedSkillMatch[index] = false
    end
  end
end
function PaGlobal_ArousalTutorial_Manager:startTutorial()
  if isFlushedUI() then
    return
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    PaGlobal_TutorialManager:endTutorial()
  end
  if true == PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() then
    PaGlobal_SummonBossTutorial_Manager:endTutorial()
  end
  Panel_ArousalTutorial:SetShow(true, true)
  PaGlobal_ArousalTutorial_Manager:setDoingArousalTutorial(true)
  PaGlobal_ArousalTutorial_UiHeadlineMessage:mainBGShow()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage():computePosAll()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_0:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_1:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_2:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:EraseAllEffect()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:EraseAllEffect()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:EraseAllEffect()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:EraseAllEffect()
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():setShowAll(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit():hideBubbleKey()
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B_Left:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_Ctrl:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_T:SetShow(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetText("")
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetShow(true)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_0:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_1:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggleAll(false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_Q", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_W", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_A", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_S", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_D", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_Shift", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_Q = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_W = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_A = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_S = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_D = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_F = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_Shift = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._m0 = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._m1 = false
  for index = 0, #questCheck[classType] do
    if questList_hasProgressQuest(questCheck[classType][index].questGroup, questCheck[classType][index].questId) then
      PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetText(questCheck[classType][index].purposeText)
      progressQuestNo._group = questCheck[classType][index].questGroup
      progressQuestNo._id = questCheck[classType][index].questId
      comboQuestClear = false
      for ii = 1, #questCheck[classType][index].combo do
        if nil ~= questCheck[classType][index].combo[ii] then
          if 1 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetTextMode(UI_TM.eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetText(PaGlobal_ArousalTutorial_Manager:getStringResize(questCheck[classType][index].combo[ii], questCheck[classType][index].comboKey[ii], 1))
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetFontColor(UI_color.C_FFC4BEBE)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetShow(true)
          elseif 2 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetTextMode(UI_TM.eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetText(PaGlobal_ArousalTutorial_Manager:getStringResize(questCheck[classType][index].combo[ii], questCheck[classType][index].comboKey[ii], 2))
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetShow(true)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetFontColor(UI_color.C_FFC4BEBE)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_0:SetShow(true)
          elseif 3 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetTextMode(UI_TM.eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetText(PaGlobal_ArousalTutorial_Manager:getStringResize(questCheck[classType][index].combo[ii], questCheck[classType][index].comboKey[ii], 3))
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetShow(true)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetFontColor(UI_color.C_FFC4BEBE)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_1:SetShow(true)
          elseif 4 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetTextMode(UI_TM.eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetText(PaGlobal_ArousalTutorial_Manager:getStringResize(questCheck[classType][index].combo[ii], questCheck[classType][index].comboKey[ii], 4))
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetShow(true)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetFontColor(UI_color.C_FFC4BEBE)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_2:SetShow(true)
          end
        end
      end
    end
  end
  for index = 0, baseComboCount - 1 do
    usedSkillKey[index] = nil
    usedSkillMatch[index] = false
  end
  _stepNo = 101
end
function PaGlobal_ArousalTutorial_Manager:updatePerFrame(deltaTime)
  if 101 == _stepNo then
    updateDeltaTime_ComboTutorial(deltaTime)
  end
end

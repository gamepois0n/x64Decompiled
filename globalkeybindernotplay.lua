local VCK = CppEnums.VirtualKeyCode
local GlobalKeyBinder_CheckKeyPressed = function(keyCode)
  return isKeyDown_Once(keyCode)
end
function GlobalKeyBinder_UpdateNotPlay(deltaTime)
  if MessageBox.isPopUp() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      MessageBox.keyProcessEnter()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBox.keyProcessEscape()
    end
    return
  end
  if nil ~= Panel_Login and Panel_Login:GetShow() then
    if nil ~= Panel_TermsofGameUse and Panel_TermsofGameUse:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
        FGlobal_HandleClicked_TermsofGameUse_Next()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        FGlobal_TermsofGameUse_Close()
      end
    elseif nil ~= Panel_Login_Password and Panel_Login_Password:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
        LoginPassword_Enter()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        LoginPassword_Cancel()
      end
    elseif nil ~= Panel_Login_Nickname and Panel_Login_Nickname:GetShow() then
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      Panel_Login_BeforOpen()
    end
  end
  if nil ~= Panel_CharacterSelectNew and Panel_CharacterSelectNew:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    CharacterSelect_Back()
  end
end
registerEvent("EventGlobalKeyBinderNotPlay", "GlobalKeyBinder_UpdateNotPlay")

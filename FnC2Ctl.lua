local appName="Add function curve to control" 
local appDescription1="1. Create functions with desired controls" 
local appDescription3="2. Assign the functions to servos" 
local appDescription41="3. Specify servo number 1 " 
local appDescription42="    Specify servo number 2 " 
local appDescription43="    Specify servo number 3 " 
local appDescription5="4. Use app controls FC1,FC2,FC3" 
local appDescription6="     as Input Control" 
local ctrlOutCreated
local servoNumber

local function servoNumber1Changed(value)
  servoNumber1=value
  system.pSave("_F2C_servoNumber1",value)
end

local function servoNumber2Changed(value)
  servoNumber2=value
  system.pSave("_F2C_servoNumber2",value)
end

local function servoNumber3Changed(value)
  servoNumber3=value
  system.pSave("_F2C_servoNumber3",value)
end

local function initForm(subform)
  form.addLabel({label=appDescription1})
  form.addLabel({label=appDescription3})
  form.addRow(2)
  form.addLabel({label=appDescription41, width=240})
  form.addIntbox (servoNumber1, 1, 24, 16,0, 1, servoNumber1Changed)
  form.addRow(2)
  form.addLabel({label=appDescription42, width=240})
  form.addIntbox (servoNumber2, 1, 24, 16,0, 1, servoNumber2Changed)
  form.addRow(2)
  form.addLabel({label=appDescription43, width=240})
  form.addIntbox (servoNumber3, 1, 24, 16,0, 1, servoNumber3Changed)
  form.addLabel({label=appDescription5})
  form.addLabel({label=appDescription6})
end


-- Init function
local function init() 
  system.registerForm(1,MENU_ADVANCED,appName,initForm) 

  servoNumber1 = system.pLoad("_F2C_servoNumber1")
  if (not servoNumber1) then
    servoNumber1 = 14
    system.pSave("_F2C_servoNumber1",value)
  end

  servoNumber2 = system.pLoad("_F2C_servoNumber2")
  if (not servoNumber2) then
    servoNumber2 = 15
    system.pSave("_F2C_servoNumber2",value)
  end

  servoNumber3 = system.pLoad("_F2C_servoNumber3")
  if (not servoNumber3) then
    servoNumber3 = 16
    system.pSave("_F2C_servoNumber3",value)
  end
  
--  local ctrlNumber = 1
--  while (not ctrlOutCreated) do
--    ctrlOutCreated = system.registerControl(ctrlNumber, "Butterfly via servo output","BFL")
--    ctrlNumber = ctrlNumber + 1
--  end

-- Use fixed control numbers, might collide with other scripts, but ensures control always is on the specific number and not dependant on script loading order.
  ctrlOut1Created = system.registerControl(2, "Ctl with Function curve 1","FC1")
  ctrlOut2Created = system.registerControl(3, "Ctl with Function curve 2","FC2")
  ctrlOut3Created = system.registerControl(4, "Ctl with Function curve 3","FC3")
end

-- Loop function
local function loop()   
  if(ctrlOut1Created and servoNumber1) then
    system.setControl(ctrlOut1Created, system.getInputs("O"..servoNumber1) ,0,0)
  end
  if(ctrlOut2Created and servoNumber2) then
    system.setControl(ctrlOut2Created, system.getInputs("O"..servoNumber2) ,0,0)
  end
  if(ctrlOut3Created and servoNumber3) then
    system.setControl(ctrlOut3Created, system.getInputs("O"..servoNumber3) ,0,0)
  end

end

return { init=init, loop=loop, author="ClausT on JetiForum.de", version="1.00",name=appName}
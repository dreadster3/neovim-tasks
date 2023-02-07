local function terraform_apply(module_config, _)
  local args = {"apply", "-auto-approve"}

  return {
    cmd = module_config.cmd,
    args = args
  }
end

local function terraform_validate(module_config, _)
  local args = {"validate"}

  return {
    cmd = module_config.cmd,
    args = args
  }
end

local function terraform_init(module_config, _) 
  local args = {"init"}

  return {
    cmd = module_config.cmd,
    args = args
  }
end

local terraform = {
  params = {
    'cmd'
  },
  condition = function ()
    return true
  end,
  tasks = {
    init = terraform_init,
    validate = {terraform_init, terraform_validate},
    apply = {terraform_init, terraform_validate, terraform_apply}
  }
}

return terraform

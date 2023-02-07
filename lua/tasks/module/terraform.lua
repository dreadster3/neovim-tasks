local function terraform_apply(module_config, _)
  local args = {"apply"}

  if module_config.auto_approve then
    table.insert(args, "--auto-approve")
  end

  return {
    cmd = module_config,
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
    'cmd',
    auto_approve = {true, false}
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

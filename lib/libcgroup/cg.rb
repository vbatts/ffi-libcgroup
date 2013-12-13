require 'ffi'

module LibCgroup
  extend FFI::Library
  ffi_lib [FFI::CURRENT_PROCESS, 'cgroup', '/lib64/libcgroup.so.1']

  typedef :pointer, :cgroup
  typedef :pointer, :controller
  typedef :pointer, :FILE

  CGFLAG_USECACHE = 0x01

  # init.h
  attach_function :cgroup_init, [], :int
  attach_function :cgroup_get_subsys_mount_point, [:string, :pointer], :int

  # tasks.h
  attach_function :cgroup_attach_task, [:cgroup], :int
  attach_function :cgroup_attach_task_pid, [:cgroup, :pid_t], :int
  attach_function :cgroup_init_rules_cache, [], :int
  attach_function :cgroup_reload_cached_rules, [], :int
  attach_function :cgroup_print_rules_config, [:FILE], :void

  # config.h
  attach_function :cgroup_config_load_config, [:string], :int
  attach_function :cgroup_unload_cgroups, [], :int
  attach_function :cgroup_config_unload_config, [:string, :int], :int
  attach_function :cgroup_config_set_default, [:string, :int], :int

  # groups.h
  attach_function :cgroup_new_cgroup, [:string], :cgroup
  attach_function :cgroup_get_cgroup, [:cgroup], :int
  attach_function :cgroup_add_controller, [:cgroup, :string], :controller
  attach_function :cgroup_get_controller, [:cgroup, :string], :controller
  attach_function :cgroup_free, [:pointer], :void
  attach_function :cgroup_free_controllers, [:cgroup], :void
  attach_function :cgroup_get_value_name, [:controller, :int], :string
  attach_function :cgroup_get_value_name_count, [:controller], :int
  attach_function :cgroup_get_value_string, [:controller, :string, :pointer], :int
end


require 'ffi'

module LibCgroup
  extend FFI::Library
  ffi_lib [FFI::CURRENT_PROCESS, 'cgroup', '/lib64/libcgroup.so.1']

  typedef :pointer, :cgroup
  typedef :pointer, :controller
  typedef :pointer, :FILE

  CGFLAG_USECACHE = 0x01

  # The application must initialize libcgroup using LibCgroup.init before any
  # other libcgroup function can be called. libcgroup caches information
  # about mounted hierarchies (just what's mounted where, not the control groups
  # themselves) at this time. There is currently no way to refresh this cache,
  # i.e. all subsequent mounts/remounts/unmounts are not reflected in this cache
  # and libcgroup may produce unexpected results.
  def self.init
    self.cgroup_init
  end

  # Returns path where is mounted given controller.
  # Only the first mount point is returned, use
  # LibCgroup.get_subsys_mount_point_begin(), LibCgroup.get_subsys_mount_point_next()
  # and LibCgroup.get_subsys_mount_point_end() to get all of them.
  #
  # controller Name of the controller
  #
  #   LibCgroup.init
  #    => 0 
  #   LibCgroup.get_subsys_mount_point("cpu")
  #    => "/sys/fs/cgroup" 
  #
  def self.get_subsys_mount_point(ctl)
    objptr = FFI::MemoryPointer.new :pointer
    self.cgroup_get_subsys_mount_point(ctl, objptr)
    strPtr = objptr.read_pointer
    return strPtr.null? ? "" : strPtr.read_string
  end

  # init.h
  attach_function :cgroup_init, [], :int
  attach_function :cgroup_get_subsys_mount_point, [:string, :pointer], :int

  # iterators.h
  #attach_function :cgroup_get_all_controller_begin, [void **handle, struct controller_data *info], :int

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


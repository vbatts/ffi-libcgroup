# Libcgroup

Bindings for the libcgroup library.
Control Groups provide mechanisms to contain, limit and account for resource
usage of process groups.


## Installation

Add this line to your application's Gemfile:

    gem 'libcgroup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install libcgroup

## Usage

    require 'libcgroup'
    puts LibCgroup.cgroup_init
    puts root = LibCgroup.cgroup_new_cgroup("/")
    puts LibCgroup.cgroup_get_cgroup(root)
    puts ctl = LibCgroup.cgroup_get_controller(root, "cpu")
    (0..(LibCgroup.cgroup_get_value_name_count(ctl)-1)).each do |i|
      name = LibCgroup.cgroup_get_value_name(ctl, i)
      s = FFI::MemoryPointer.new :pointer, 1
      LibCgroup.cgroup_get_value_string(ctl, name, s)
      strPtr = s.read_pointer
      if strPtr.null?
        puts name
      else
        puts "#{name} #{strPtr.read_string}"
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Checkout https://github.com/ffi/ffi/wiki/Examples for FFI introduction.

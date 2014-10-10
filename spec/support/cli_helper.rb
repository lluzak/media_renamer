def ignore_system_exit
  yield
rescue SystemExit => e
  e
end

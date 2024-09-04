{
  services.udev.extraHwdb = ''
    #3M EXII TOUCH-CONTROLLER CUSTOM-COORDINATE-RES-FUZZ VALUES

    evdev:input:b0003v0596p0001*
     EVDEV_ABS_00=2600:14000:34:100
     EVDEV_ABS_01=2450:13800:43:100
   '';

   services.udev.extraRules = ''
     # Mirror X-Axis of 3M EXII Touch Controller

     ENV{ID_VENDOR_ID}=="0596",ENV{ID_MODEL_ID}=="0001",ENV{LIBINPUT_CALIBRATION_MATRIX}="-1 0 1 0 1 0"
   '';
}

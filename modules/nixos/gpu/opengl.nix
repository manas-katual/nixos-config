{

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  #services.xserver.videoDrivers = ["amdgpu"];
  #services.xserver.videoDrivers = ["modesetting"];


}

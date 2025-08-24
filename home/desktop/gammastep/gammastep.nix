{ ... }:

{
  services.gammastep = {
    enable = true;

    # Approximately Vancouver
    provider = "manual";
    latitude = 49.3;
    longitude = -123.1;

    temperature = {
      day = 5500;
      night = 3000;
    };

    # Specify the times to align with my sleep "schedule"
    dawnTime = "6:00-6:30";
    duskTime = "21:00-21:30";
  };
}

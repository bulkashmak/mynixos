# Two-NVMe layout for the formd PC.
#
# first  (nvme0n1, 2 TB): ESP + swap + btrfs root/home/nix. Fully Linux.
# second (nvme1n1, 2 TB): 500 G reserved for a Windows install (unformatted;
#                         the Windows installer partitions/formats it),
#                         remainder as a btrfs data volume at /mnt/data.
{
  disko.devices = {
    disk = {
      first = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "2G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            swap = {
              size = "32G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };

      second = {
        device = "/dev/nvme1n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # Reserved for a future Windows install. Marked as Microsoft basic
            # data so Windows setup will pick it up; left unformatted here so
            # disko never touches the contents on a rebuild.
            windows = {
              size = "500G";
              type = "0700";
            };

            data = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@data" = {
                    mountpoint = "/mnt/data";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

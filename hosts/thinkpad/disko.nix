# To partition, format and mount run this command
# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix
# nixos-generate-config --root /mnt && nixos-install
{
  disko.devices = {
    disk.main = {
      # TODO: verify with `lsblk` in the live ISO. The `nvme` kernel module is loaded
      # in hardware-configuration.nix, so the actual device is most likely
      # `/dev/nvme0n1`. For stability prefer `/dev/disk/by-id/...`.
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # 1. UEFI System Partition (ESP) — 500 M, vfat, holds the systemd-boot binary.
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/efi";
              mountOptions = [ "umask=0077" ];
            };
          };

          # 2. /boot — 2 G, ext4. Uses the XBOOTLDR GPT type (EA00) so systemd-boot
          # picks up kernels and initrds from here instead of from the ESP. Without
          # the EA00 type code the bootloader will silently ignore this partition.
          boot = {
            type = "EA00";
            size = "2G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
            };
          };

          # 3. Swap partition — 16 G. resumeDevice=true wires the kernel resume= param
          # for hibernation. Coexists with zramSwap (zram has higher priority by default).
          swap = {
            size = "16G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          # 4. Root — btrfs with subvolumes for /, /home and /nix.
          # MUST be last: disko allocates partitions in declaration order and `100%`
          # consumes whatever space is left.
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
                # Kept on its own subvolume so future snapper/btrbk snapshots
                # of / and /home don't include the (rebuildable) Nix store.
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
  };
}

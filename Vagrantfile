Vagrant.configure("2") do |config|
    # Alpine Linux VM
    config.vm.define "alpine" do |alpine|
      alpine.vm.box = "generic/alpine313"
      alpine.vm.provision "shell" do |shell|
        shell.inline = <<-SHELL
          echo "Installing required packages..."
          apk update
          apk add --no-cache git curl
          echo "Copying script to VM..."
          cp /vagrant/script.sh /tmp/script.sh
          echo "Running script..."
          chmod +x /tmp/script.sh
          /tmp/script.sh
        SHELL
      end
    end
  
    # Arch Linux VM
    config.vm.define "arch" do |arch|
      arch.vm.box = "archlinux/archlinux"
      arch.vm.provision "shell" do |shell|
        shell.inline = <<-SHELL
          echo "Installing required packages..."
          pacman -Sy --noconfirm git curl
          echo "Copying script to VM..."
          cp /vagrant/script.sh /tmp/script.sh
          echo "Running script..."
          chmod +x /tmp/script.sh
          /tmp/script.sh
        SHELL
      end
    end
  end
  
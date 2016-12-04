Purpose
=======

This is a mixture between quide and docuemntion about how to quickly and easily create windows test vm's.

In the beginning...
===================

These steps are only necessary once.

1. [Install Chocolatey][1]
1. Install VirtualBox
    ```
    choco install virtualbox --version 5.1.10
    choco pin add -n=virtualbox --version=5.1.10
    ```

1. Unzip and import the file downloaded from [here][1]
2. Because the VM will expire in in 90 days, make an snapshot before booting the VM. You can make any adjustments to the VM without booting it, i.e:

   - Network: To reduce unecessary chatter with the mothership set this to host only.
   - Clipboard/Drop & Drop Sharing

    These steps are only necessary once.
    
1. Make a snapshot "NotBootedYet"
2. Install `vagrant`
    ```
    choco install vagrant
    ```

(Re)create base image
=====================

Repeat these steps to create a new [box][2]. 

This will setup the VM so `vagrant` can administer it:

1. Boot the VM for the first time
1. open an administrative command prompt
   1. `notepad prep.cmd`
   2. paste the content from `prep.cmd` from this git repository. This will configure `WinRM` to work nicely with `vagrant`.
   3. save and run `prep.cmd`

   This will spew out a few errors but it did work for me.
1. shutdown the VM. You might want to create a snapshot.
2. Package the VM:
    ```
    vagrant package --base "MSEdge - Win10_preview" --output windows.box --vagrantfile BaseImage\Vagrantfile
    ```
    
    `MSEdge - Win10_preview` is the name of the image in VirtualBox.
1. Import box:
    ```
    vagrant box add windows.box --name win10box
    ```

Everyday life
=============

After all this work you can now easly spawn new VM:

```
    mkdir fooVM
    cd fooVM
    vagrant init test001
    vagrant up
```

Have a look at the examples inside this git repository.

Debugging and ressources
========================

*  [Creating a Windows 10 Base Box for Vagrant with VirtualBox][4]

WinRM/RS
--------
To test the RCP you'll need to add the IP of the host to the Hypervisor:
```
winrm set winrm/config/client @{TrustedHosts="192.168.56.101"}
```

Now you should be cable to connect to the guest:
```
winrs -r:192.168.56.101 -u:IEUser -p:Passw0rd! cmd.exe
```


[1]: https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/
[2]: https://chocolatey.org/install
[3]: https://www.vagrantup.com/docs/boxes.html
[4]: http://huestones.co.uk/node/305
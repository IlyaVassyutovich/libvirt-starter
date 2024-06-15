import libvirt


def is_vm_running(conn, vm_name):
    try:
        domain = conn.lookupByName(vm_name)
        return domain.info()[0] == libvirt.VIR_DOMAIN_RUNNING
    except libvirt.libvirtError:
        return False


def main():
    print("Hello, this is my Python app using libvirt!")
    with libvirt.open("qemu:///system") as connection:
        if is_vm_running(connection, "docker-02"):
          print("Domain docker-02 is runnning")


if __name__ == "__main__":
    main()

data template_file "userdata" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    username = var.username
    ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGJcdO44CubnrhkN6V2sqoVnUY87iTBow9uz73gvEmxl egor.solt@yandex.ru"
    ssh_key = "b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZWQyNTUxOQAAACBiXHTuOArm564ZDeldrKqFZ1GPO4kwaMPbs+94LxJsZQAAAJhICfsKSAn7CgAAAAtzc2gtZWQyNTUxOQAAACBiXHTuOArm564ZDeldrKqFZ1GPO4kwaMPbs+94LxJsZQAAAEBwRF1tuWP/ATc2hqRINYj+Fo1UCHYa/m7vr9U97yZJqGJcdO44CubnrhkN6V2sqoVnUY87iTBow9uz73gvEmxlAAAAE2Vnb3Iuc29sdEB5YW5kZXgucnUBAg=="
    }
}


$ssh_host = "54.53.52.51"
$ssh_user = "ec2-user"
$ssh_pass = ""
$ssh_port = "22"
$ssh_cert = "c:\the_path_to_your_sertificate\ec2-user.pem"
$ssh_forvard_host = "192.168.0.10"
$ssh_forvard_port = "5432"
$ssh_local_port = "54320"

$ssh_connection_string = "ssh -L $ssh_local_port<:>$ssh_forvard_host<:>$ssh_forvard_port $ssh_user@$ssh_host -p $ssh_port -i $ssh_cert"
# $ssh_connection_string = "ssh -D $ssh_local_port $ssh_user@$ssh_host -p $ssh_port -i $ssh_cert"
$ssh_connection_string = $ssh_connection_string.Replace("<:>",":")
$i = 0
while ("true") {
    $i++;
    echo "count re-connection: $i : $ssh_connection_string"
    Start-Sleep -Seconds 1
    Invoke-Expression $ssh_connection_string
}

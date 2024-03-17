#! python alrc-termux.module
# Automations by @luisadha
from halo import Halo
import subprocess
from time import sleep

# Menjalankan termux-media-player dan menangkap outputnya
output_lines = []
command = "cd ~ && termux-media-player info | sed -n 's/Track: \(.*\)/\\1/p'"
process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, text=True)

# Menampilkan spinner
spinner = Halo(text='', spinner='dots')
spinner.start()

try:
    while True:
        output = process.stdout.readline()
        if process.poll() is not None and not output:
            break
        if output:
            output_lines.append(output.strip())
            sleep(0.5)
except KeyboardInterrupt:
    # Tangkap jika pengguna menekan Ctrl+C untuk menghentikan program
    pass

# Menunggu proses selesai dan mendapatkan kode keluar
return_code = process.wait()
# Menampilkan output terakhir (jika ada)
final_output, _ = process.communicate()
if final_output:
    print(final_output.strip())

# Menyusun output berdasarkan list output_lines
current_output = " ".join(output_lines)
#print(current_output)


spinner.stop_and_persist(symbol='🎵'.encode('utf-8'), text=current_output)
#except (KeyboardInterrupt, SystemExit):
    

spinner.stop()

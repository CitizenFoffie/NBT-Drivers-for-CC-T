# NBT-Drivers-for-CC-T
Get information from NBT Files on a CC:T device
must be uncompressed, just do 7zip extract all on your nbt file till it gives you a plain file and then drag it into your cc computer.
then do local file - fs.open('/name',"rb")
and then  local data = readNBTData(file, 10)

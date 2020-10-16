import numpy as np
import soundfile as sf
import os
import scipy.io

directory_ogg = '../sound-test/ogg/'
directory_flac = '../sound-test/flac/'

list_effect_ogg = os.listdir(directory_ogg)
list_effect_flac = os.listdir(directory_flac)
limit = 31

list_effect_ogg.sort()
list_effect_flac.sort()

X = np.zeros(len(list_effect_ogg), list)
y = np.zeros(len(list_effect_flac), list)

i = 0;
for f in list_effect_ogg[0:limit]:
    song = f
    data, samplerate = sf.read(directory_ogg + song)
    row = []

    for r in data:
        row.append(r)
		

    X[i] = row
    i += 1
    

i = 0;
for f in list_effect_flac[0:limit]:
    song = f
    data, samplerate = sf.read(directory_flac + song)
    row = []

    for r in data:
        row.append(r)


    y[i] = row
    i += 1


scipy.io.savemat('data.mat', mdict={'X': X, 'y': y})

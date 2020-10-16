import numpy as np
import soundfile as sf
import os
import scipy.io
from pydub import AudioSegment


directory_mp3 = '../sound-test/mp3/'
directory_flac = '../sound-test/flac/'

list_effect_mp3 = os.listdir(directory_mp3)
list_effect_flac = os.listdir(directory_flac)
limit = 1

list_effect_mp3.sort()
list_effect_flac.sort()

X = np.zeros(len(list_effect_mp3), list)
y = np.zeros(len(list_effect_flac), list)

i = 0;
for f in list_effect_mp3[0:limit]:
    song = f
    #data, samplerate = sf.read(directory_mp3 + song)
    data = AudioSegment.from_mp3(directory_mp3 + song)
    samples = data.get_array_of_samples()
    row = []
    print(len(samples))

    for r in samples:
        row.append(r)
		

    X[i] = row
    i += 1
    

i = 0;
for f in list_effect_flac[0:limit]:
    song = f
    data, samplerate = sf.read(directory_flac + song)
    print(len(data))
    row = []

    for r in data:
        row.append(r)


    y[i] = row
    i += 1


scipy.io.savemat('data-mp3.mat', mdict={'X': X, 'y': y})

sudo apt-get install libmp3lame-dev libxvidcore-dev && \
git clone https://github.com/FFmpeg/FFmpeg.git && \
cd FFmpeg && \
./configure  --enable-libxvid --enable-gpl --enable-libmp3lame  && \
make && make install 
FROM i386/debian
RUN sed -i 's/ main/ main contrib non-free/g' /etc/apt/sources.list.d/* && \
  dpkg --add-architecture i386 && \
  apt-get update -y && \
  apt-get install -y tigervnc-standalone-server openbox wget wine32 pulseaudio winetricks && \
  rm -rf /var/lib/apt/lists
RUN wget https://d2j9xt6n9dg5d3.cloudfront.net/win/24780926_1c962c14fdc55b2e347aeb3c3ffc5ee6/AmazonMusicInstaller.exe
RUN winetricks -q allfonts --force
ENV VNC_DESKTOP_NAME "Xtigervnc"
ENV VNC_GEOMETRY 1280x800
RUN mkdir -p /exo && wget https://github.com/deref/exo/releases/download/2021.11.16/exo_standalone_2021.11.16_linux_amd64.tar.gz -O- | tar xvz && mv exo /usr/local/bin && chmod +x /usr/local/bin/exo && rm -rf /exo
COPY app/ /app/
RUN wine "regedit" "z:\app\gdi.reg"
COPY root/.config/openbox/ /root/.config/openbox/
CMD /app/main.sh

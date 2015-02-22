# use ubuntu package for squeezelite
FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install squeezelite alsa-utils --no-install-recommends -y


# avoid running as root. Add user to audio group for access to soundcard
RUN useradd -G audio squeezelite
RUN mkdir /home/squeezelite
RUN chown -R squeezelite /home/squeezelite

USER squeezelite

# allow native format playback in the soundcard. Monitor with something like:
# watch -n 5 cat /proc/asound/card0/pcm0p/sub0/hw_params
COPY asoundrc /home/squeezelite/.asoundrc

CMD /usr/bin/squeezelite -n `hostname`


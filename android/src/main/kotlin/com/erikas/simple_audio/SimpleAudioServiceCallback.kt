package com.erikas.simple_audio

import android.support.v4.media.session.MediaSessionCompat

/**
 * Handles the common callbacks from the media
 * notification.
 */
class SimpleAudioServiceCallback: MediaSessionCompat.Callback()
{
    override fun onPlay() {
        if(simpleAudioService!!.isPlaying)
        {
            onPause()
            return
        }

        channel.invokeMethod("play", null)
        super.onPlay()
    }

    override fun onPause() {
        if(!simpleAudioService!!.isPlaying)
        {
            onPlay()
            return
        }

        channel.invokeMethod("pause", null)
        super.onPause()
    }

    override fun onStop() {
        simpleAudioService!!.kill()
        super.onStop()
    }

    override fun onSkipToNext() {
        channel.invokeMethod("next", null)
        super.onSkipToNext()
    }

    override fun onSkipToPrevious() {
        channel.invokeMethod("previous", null)
        super.onSkipToPrevious()
    }

    override fun onFastForward() {
        channel.invokeMethod("seekRelative", true)
        super.onFastForward()
    }

    override fun onRewind() {
        channel.invokeMethod("seekRelative", false)
        super.onRewind()
    }

    override fun onSeekTo(pos:Long) {
        channel.invokeMethod("seek", pos / 1000)
        super.onSeekTo(pos)
    }
}
// This file is a part of simple_audio
// Copyright (c) 2022-2023 Erikas Taroza <erikastaroza@gmail.com>
//
// This program is free software: you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License along with this program.
// If not, see <https://www.gnu.org/licenses/>.

#if os(macOS)
import FlutterMacOS
#else
import Flutter
import AVFoundation
#endif

import MediaPlayer

@available(macOS 10.12.2, *)
public class SimpleAudio
{
    var channel: FlutterMethodChannel
    var currentMetadata: [String: Any] = [:]
    
    var useMediaController: Bool = true

    init(channel: FlutterMethodChannel?)
    {
        self.channel = channel!
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)
    {
        switch call.method
        {
            case "init":
                let args: [String: Any] = call.arguments as! [String: Any]
            
                useMediaController = args["useMediaController"] as! Bool
                if(!useMediaController) { return }

                let actions = args["actions"] as! [Int]
                let preferSkipButtons = args["preferSkipButtons"] as! Bool
            
                initialize(actions: actions.map { try! MediaControlAction.fromInt(i: $0) }, preferSkipButtons: preferSkipButtons)
            case "dispose":
                dispose()
            case "setMetadata":
                let args: [String: Any] = call.arguments as! [String: Any]
                    
                if(!useMediaController) { return }
            
                setMetadata(
                    title: args["title"] as? String,
                    artist: args["artist"] as? String,
                    album: args["album"] as? String,
                    artUri: args["artUri"] as? String,
                    artBytes: args["artBytes"] as? FlutterStandardTypedData,
                    duration: args["duration"] as? Int
                )
            case "setPlaybackState":
                let args: [String: Any] = call.arguments as! [String: Any]
                    
                if(!useMediaController) { return }
            
                setPlaybackState(
                    state: args["state"] as? Int,
                    position: args["position"] as? Int
                )
            default:
                result(FlutterMethodNotImplemented)
        }
    }
    
    func initialize(actions: [MediaControlAction], preferSkipButtons: Bool)
    {
        #if os(iOS)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playback)
        try! session.setActive(true)
        #endif
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        if(actions.contains(MediaControlAction.playPause))
        {
            commandCenter.playCommand.isEnabled = true
            commandCenter.playCommand.addTarget { event in
                self.channel.invokeMethod("play", arguments: nil)
                return .success
            }
            
            commandCenter.pauseCommand.isEnabled = true
            commandCenter.pauseCommand.addTarget { event in
                self.channel.invokeMethod("pause", arguments: nil)
                return .success
            }
        }
        
        if(actions.contains(MediaControlAction.skipPrev))
        {
            commandCenter.previousTrackCommand.isEnabled = true
            commandCenter.previousTrackCommand.addTarget { event in
                self.channel.invokeMethod("previous", arguments: nil)
                return .success
            }
        }
        
        if(actions.contains(MediaControlAction.skipNext))
        {
            commandCenter.nextTrackCommand.isEnabled = true
            commandCenter.nextTrackCommand.addTarget { event in
                self.channel.invokeMethod("next", arguments: nil)
                return .success
            }
        }
        
        if(actions.contains(MediaControlAction.fastForward) && !preferSkipButtons)
        {
            commandCenter.skipForwardCommand.isEnabled = true
            commandCenter.skipForwardCommand.preferredIntervals = [10.0]
            commandCenter.skipForwardCommand.addTarget { event in
                self.channel.invokeMethod("seekRelative", arguments: true)
                return .success
            }
        }
        
        if(actions.contains(MediaControlAction.rewind) && !preferSkipButtons)
        {
            commandCenter.skipBackwardCommand.isEnabled = true
            commandCenter.skipBackwardCommand.preferredIntervals = [10.0]
            commandCenter.skipBackwardCommand.addTarget { event in
                self.channel.invokeMethod("seekRelative", arguments: false)
                return .success
            }
        }
        
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { event in
            let seconds = (event as! MPChangePlaybackPositionCommandEvent).positionTime
            self.channel.invokeMethod("seek", arguments: Int(seconds.rounded(.down)))
            return .success
        }
        
        #if os(macOS)
        let nowPlaying = MPNowPlayingInfoCenter.default()
        nowPlaying.playbackState = MPNowPlayingPlaybackState.unknown
        #endif
    }
    
    func dispose()
    {
        #if os(iOS)
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        #endif

        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = false
        commandCenter.pauseCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.skipForwardCommand.isEnabled = false
        commandCenter.skipBackwardCommand.isEnabled = false
        commandCenter.changePlaybackPositionCommand.isEnabled = false

        let nowPlaying = MPNowPlayingInfoCenter.default()
        if #available(iOS 13.0, *) {
            nowPlaying.playbackState = MPNowPlayingPlaybackState.unknown
        }
        nowPlaying.nowPlayingInfo = [:]
    }
    
    func setMetadata(
        title: String?,
        artist: String?,
        album: String?,
        artUri: String?,
        artBytes: FlutterStandardTypedData?,
        duration: Int?
    )
    {
        currentMetadata = [
            MPNowPlayingInfoPropertyDefaultPlaybackRate: 1.0,
            MPMediaItemPropertyTitle: title ?? "Unknown Title",
            MPMediaItemPropertyArtist: artist ?? "Unknown Artist",
            MPMediaItemPropertyAlbumTitle: album ?? "Unknown Album",
            MPMediaItemPropertyPlaybackDuration: duration ?? 0,
        ]
        
        if(artUri != nil || artBytes != nil)
        {
            let size = CGSize(width: 200, height: 200)
            
            #if os(macOS)
            if #available(macOS 10.13.2, *) {
                let artwork = MPMediaItemArtwork(boundsSize: size, requestHandler: { size in
                    if(artUri != nil) {
                        return NSImage(contentsOf: URL(string: artUri!)!)!
                    }
                    else if(artBytes != nil) {
                        return NSImage(data: artBytes!.data)!
                    }
                    
                    return NSImage()
                })
                currentMetadata[MPMediaItemPropertyArtwork] = artwork
            }
            #else
            let artwork = MPMediaItemArtwork(boundsSize: size, requestHandler: { size in
                if(artUri != nil) {
                    let data = try! Data(contentsOf: URL(string: artUri!)!)
                    return UIImage(data: data)!
                }
                else if(artBytes != nil) {
                    return UIImage(data: artBytes!.data)!
                }
                
                return UIImage()
            })
            currentMetadata[MPMediaItemPropertyArtwork] = artwork
            #endif
        }
        
        let state = MPNowPlayingInfoCenter.default()
        state.nowPlayingInfo = currentMetadata
    }
    
    // See enum type PlaybackState in simple_audio.dart for integer values.
    func setPlaybackState(state: Int?, position: Int?)
    {
        let nowPlaying = MPNowPlayingInfoCenter.default()
        
        #if os(macOS)
        var translatedState: MPNowPlayingPlaybackState
        
        switch(state)
        {
            case 0: translatedState = MPNowPlayingPlaybackState.playing
            case 1: translatedState = MPNowPlayingPlaybackState.paused
            case 2: translatedState = MPNowPlayingPlaybackState.stopped
            default: translatedState = MPNowPlayingPlaybackState.unknown
        }
        
        nowPlaying.playbackState = translatedState
        #else
        let session = AVAudioSession.sharedInstance()

        if state == 0
        {
            currentMetadata[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
            try? session.setActive(true)
        }
        else
        {
            currentMetadata[MPNowPlayingInfoPropertyPlaybackRate] = 0.0
            // Allow some time for the Rust code to execute
            // to pause the stream.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                // setActive will throw an error (and stop playback) if
                // it is given `false` when audio is still playing.
                // Call this only if there is nothing playing.
                self.channel.invokeMethod("isPlaying", arguments: nil) { res in
                    if(res is Bool && !(res as! Bool)) {
                        try? session.setActive(false)
                    }
                }
            }
        }
        #endif
        
        currentMetadata[MPNowPlayingInfoPropertyElapsedPlaybackTime] = String(position ?? 0)
        nowPlaying.nowPlayingInfo = currentMetadata
    }
}

enum MediaControlAction
{
    case rewind
    case skipPrev
    case playPause
    case skipNext
    case fastForward
                
    static func fromInt(i: Int) throws -> MediaControlAction
    {
        switch(i)
        {
            case 0: return .rewind
            case 1: return .skipPrev
            case 2: return .playPause
            case 3: return .skipNext
            case 4: return .fastForward
            default: throw InvalidActionError.invalid
        }
    }
}

enum InvalidActionError:Error
{
    case invalid
}

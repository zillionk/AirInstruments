import java.util.*;

class Recorder {  
  
  /*
  * Variables
  */
  
  // State of recording/playing/quantizing
  public boolean isRecording;
  public boolean isPlaying;
  public boolean isRecorded;
  boolean isQuantizing;
  // Quantization factor
  // 1 means quantization to beats, 2 means to half beats, 4 to quarter, etc...
  int factor;
  
  // Data structure for storing notes/time
  ArrayList<SoundTime> soundTimes;
  
  // Data structure for storing notes/time
  ArrayList<SoundTime> tempSoundTimes;
  
  // Depends upon BPM from Metronome
  
  /*
  * Constructor
  */
  public Recorder() {
    isRecording = false;
    isPlaying = false;
    isRecorded = false;
    isQuantizing = true;
    factor = 2;
    soundTimes = new ArrayList<SoundTime>();
    tempSoundTimes = new ArrayList<SoundTime>();
  }
  
  /*
  * Methods
  */
  
  // Start recording
  public void startRecording() {
    isRecording = true;
  }
  
  // Stop recording
  public void stopRecording() {
    isRecording = false;
  }
  
  // Start playing
  public void startPlaying() {
    isPlaying = true;
  }
  
  // Stop playing
  public void stopPlaying() {
    isPlaying = false;
  }
  //check if there is any content be recorded.
  public boolean isRecordedSomething() {
    return isRecorded;
  }
  
  // Quantize Input
  public float quantizeInput(float inScale) {

    float beatScale = 1/(mn.beatNum*factor);
    
    for (int i = 0; i <= mn.beatNum*factor; i++) {
      if ( (inScale - i*beatScale ) < beatScale/2 ) {
        return i*beatScale == 1 ? 0 : i*beatScale;
      }
    }
    return 200;
  }
  
  // Record Input
  public void recordInput(float inTime, String inSound) {
    // Scale the input time
    
    float thisScale = mn.calcScale(inTime);
    if (isQuantizing) {
      thisScale = quantizeInput(thisScale);
    }
    // Create the soundTime
    SoundTime newSoundTime = new SoundTime(thisScale, inSound);
    // Add it to the list
    tempSoundTimes.add(newSoundTime);
    // Sort the list
    Collections.sort(tempSoundTimes);
   
  }
  
  // Save the temporary sound times to the saved sound times; clear the temporary
  public void saveRecording() {
    // Copy each temporary soundtime over to the saved set
    int tempSaveSize = tempSoundTimes.size();
    if(tempSaveSize == 0){
      return;
    }
    for (int i = 0; i < tempSaveSize; i++) {
      soundTimes.add(tempSoundTimes.get(i));
    }
    // Clear the temporary and sort the saved
    tempSoundTimes.clear();
    Collections.sort(soundTimes);
    isRecorded = true;
  }
  
  // Clear all of the recordings
  public void clearRecording() {
    tempSoundTimes.clear();
    soundTimes.clear();
    isRecorded = false;
  }
  
  // Cancel the recording, clearing just the temporary recoridng
  public void cancelRecording() {
    tempSoundTimes.clear();
  }
    
  
}

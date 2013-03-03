module Serialization where
  
import Data.Binary  
import Codec.Compression.GZip

storeModel m = compress (encode m)
     
loadModel m = decode (decompress m)
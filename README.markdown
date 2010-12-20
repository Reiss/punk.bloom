PUNK.BLOOM is a tiny AS3 library for doing light blooms in [FlashPunk](http://www.flashpunk.net "FlashPunk")
------------------------------------------------------------------------------------------------------------

There are two classes: BloomLighting and BloomWrapper. 
The demo folder holds a compilable demo, as an example of
how to use the library.

MINI DOCS:
-----------
(for more in-depth documentation, check out the wiki up top)

BloomLighting extends Entity, and needs to be added to the current
World. The lighting will show up on whatever layer the BloomLighting
object is set to -- don't worry, though, the Entities themselves
will keep their normal layering. For most purposes, I'd recommend
setting the BloomLighting to the layer above your Entities: that way,
the bloom will blend on top of them.

BloomWrapper is just a wrapper class for your Graphics; if you want a 
Graphic object to bloom, just create a new BloomWrapper object and
pass the Graphic into its constructor. Set the Entity's graphic property
to the BloomWrapper, and you're almost ready to go. All you have to do
now is pass your newly-created BloomWrapper to the BloomLighting's
register() function, and your object will bloom flawlessly. Don't worry
that the Entity's old graphic is now inside the wrapper -- it'll still
render normally, on the appropriate Entity layer.
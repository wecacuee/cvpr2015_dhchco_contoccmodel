Hello everyone,
      I am Vikas and today I am going to present my work on continuous
      occlusion modeling for 3D Localization which is a part of the problem of
      road scene understanding for autonomous driving. This work has been
      supervised by my internship mentor Manmohan Chandrakar and my advisor
      Jason Corso.

Lets begin by understanding the problem we are trying to solve. In the
application of autonomous driving, we need to know the position orientation
and dimensions of other traffic participants in the scene. We call this the
problem of 3D localization. In particular given video feed from a
monocular camera, GPS and Map information, we want to determine the 3D
localization of traffic participants in the scene. Please note that we assume
that egomotion, that is the position of the camera over time is already
computed through other system and is given to us.

Here is an example input frame and a possible output from the system. Note
that the green bounding boxes are the detections while yellow bounding boxes
are the output of our system. They show the position, orientation and size of
the car. The image below is the top view of the scene, where red line is the
path of camera over the last 5 frames, the camera is facing towards right and
the traffic participants are show in blue. The labeled lanes are shown in
black while the lane from map and GPS is shown in green.

The natural question to ask is what has already been done? We present a few
works that closely but not exactly match our requirements. A closely related
work is that of Wojek et al from group at MPI. They use occlusion aware
partial detectors and bottom-up pixel labeling to perform tracking by
detection. However, they do not model traffic-traffic interaction such as
collision, neither do they model traffic-scene interaction such as lane
detections.

The work of Geiger et al proposes an intersection scene understanding model
using stereo data, allowing them to use features like scene flow and occupancy
grid. They do model lane information but their model is very
restrictive as it allows traffic participants to be localized only on the
estimated lanes with discretized position on the lane. Also, they do not
explicitly model occlusion.

Milan et al describe a continuous occlusion model that models detected
bounding boxes as soft ellipses and they do use traffic-traffic interactions
like collision constraints but they do not employ traffic-scene interactions
like lane constraints in their framework.

Overall we are missing a framework that has models both traffic-traffic and
traffic-scene interactions and also we can use more principled occlusion
modeling.

Here we introduce a graphical model for a single car or traffic participant.

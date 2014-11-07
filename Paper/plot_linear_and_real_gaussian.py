import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D # for projection='3d' to work
import sys


def gaussianLinear1D(xx, yy, filename):
    # plot linear low dimensional approximation of guassian
    # this is like taking manhattan distance as approximation for euclidean
    phi_xx = np.exp(-xx**2/0.4)
    phi_yy = np.exp(-yy**2/0.9)
    fig = plt.figure()
    #ax = fig.add_subplot(111, projection='3d')
    #ax.plot_wireframe(xx, yy, phi_xx + phi_yy, colors='r')
    fig.add_subplot(111).matshow(phi_xx + phi_yy)
    fig.savefig(filename)

def gaussian2D(xx, yy, filename):
    # plot real gaussian
    #ax.plot_wireframe(xx, yy, np.exp(-(xx**2/0.4 + yy**2/0.9)), colors='g')
    fig2 = plt.figure()
    fig2.add_subplot(111).matshow(np.exp(-(xx**2/0.4 + yy**2/0.9)))
    fig2.savefig(filename)

########################
# main
#######################

filename = sys.argv[1]


x = np.linspace(-1, 1, num=20)
y = np.linspace(-1, 1, num=20)
xx, yy = np.meshgrid(x, y)

if 'gaussianLinear1D' in filename:
    gaussianLinear1D(xx, yy, filename)
elif 'gaussian2D' in filename:
    gaussian2D(xx, yy, filename)
else:
    raise ValueError("Don't understand plot type from filename %s" %
                       filename)

# show
#plt.show()

import numpy as np
import matplotlib.pyplot as plt

def sigmoid(z):
  return 1. / (1. + np.exp(-z))

def trainTwoLayerPerceptron(X, y, W1, W2, trainIters, learningRate):
  

def main():
  
  X = np.array([[ 0,  0],
                [ 1,  0],
                [ 0,  1],
                [ 1,  1]])
  y = np.array([0, 1, 1, 0])  # XOR

  # add constant feature
  X = np.hstack((np.ones((4,1)), X))

  W1           = np.ones((2, X.shape[1])) # initial weights
  W2           = np.array([1., -1.])
  trainIters   = 10**5                    # training iters
  learningRate = 0.1                      # learning rate

  np.random.seed(8888)
  scoreF = trainTwoLayerPerceptron(X, y, W1, W2, trainIters, learningRate)

  fig = plt.figure()
  plt.scatter(X[:,1], X[:,2], marker = "o", c = y)
  xGrid = np.linspace(-0.5, 1.5, 200)
  yGrid = np.linspace(-0.5, 1.5, 200)
  xMesh, yMesh = np.meshgrid(xGrid, yGrid)
  Z = np.zeros((200,200))
  for i1 in range(xGrid.shape[0]):
    for i2 in range(yGrid.shape[0]):
      Z[i1,i2] = scoreF(np.array([1., xGrid[i1], yGrid[i2]]))
  plt.contour(xMesh, yMesh, Z, 10)
  
  return

if __name__ == '__main__':
    main()
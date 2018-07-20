import numpy as np
import matplotlib.pyplot as plt

def trainPerceptron(X, y, w, trainIters, learningRate):
  

def main():
  
  X = np.array([[ 0,  0],
                [ 1,  0],
                [ 0,  1],
                [ 1,  1]])
  y = np.array([0, 0, 0, 1])  # AND
  # y = np.array([0, 1, 1, 1])  # OR

  # add constant feature
  X = np.hstack((np.ones((4,1)), X))

  w            = np.ones(X.shape[1])  # initial weights
  trainIters   = 1000                 # training iters
  learningRate = 0.01                 # learning rate

  np.random.seed(8888)
  w = trainPerceptron(X, y, w, trainIters, learningRate)

  fig = plt.figure()
  plt.scatter(X[:,1], X[:,2], marker = "o", c = y)
  xGrid = np.linspace(-0.5, 1.5, 200)
  decisionBddF = lambda x: -(w[1] * x + w[0]) / w[2]
  plt.plot(xGrid, decisionBddF(xGrid), 'k-')

  return

if __name__ == '__main__':
    main()
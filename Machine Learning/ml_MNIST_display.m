function ml_MNIST_display
% Download the MNIST data from Canvas 
% or from Yann LeCun's website at Courant: 
% http://yann.lcun.com/exdb/mnist/index.html
% Put the 4 files in the same directory as this code,and unzip them.
[trainImages,trainLabels] = loadMNIST('train-images-idx3-ubyte','train-labels-idx1-ubyte');
[testImages,testLabels] = loadMNIST('t10k-images-idx3-ubyte','t10k-labels-idx1-ubyte');
%t10k-images-idx3-ubyte	t10k-labels-idx1-ubyte	train-images-idx3-ubyte  train-labels-idx1-ubyte

% view the first 12 images
figure;
for k = 1:12
    subplot(3,4,k);
    pcolor(flipud(trainImages(:,:,k)));
    title(num2str(trainLabels(k)));
    % pcolor(flipud(testImages(:,:,k)));
    % title(num2str(testLabels(k)));
end
colormap gray
sgtitle('Some samples from 0-9 MNIST data');

% Reduce the data set. Look only at the zeros and ones to get started.
% Find indices of 0 and 1 digits.
idx = ((trainLabels == 0) | (trainLabels == 1));

% Reduce the data set. Filter images and labels:
binaryTrainImages = trainImages(:,:,idx);
binaryTrainLabels = trainLabels(idx);

% view the first 12 images
figure;
for k = 1:12
    subplot(3,4,k);
    pcolor(flipud(binaryTrainImages(:,:,k)));
    title(num2str(binaryTrainLabels(k)));
    % pcolor(flipud(testImages(:,:,k)));
    % title(num2str(testLabels(k)));
end
colormap gray
sgtitle('Some samples from binary MNIST data');

end % === END MAIN FUNCTION ===============================================

function [images,labels] = loadMNIST(imageFile,labelFile)
    % Load MNIST images and labels
    % Open the files
    fid1 = fopen(imageFile,'r','b'); % 'r' = read, 'b' = Big-endian format
    fid2 = fopen(labelFile,'r','b');

    % We must read the first few bits of data to get to the data we need.
    % First read the magic numbers.
    % Magic Number: The first 4 bytes (32 bits) in each MNIST file. 
    % For the MNIST dataset:
    % The magic number for label files is 2049.
    % The magic number for image files is 2051.
    magic1 = fread(fid1,1,'int32');
    magic2 = fread(fid2,1,'int32');

    % Read the number of images and labels
    numImages = fread(fid1,1,'int32');
    numLabels = fread(fid2,1,'int32');

    % Read the image dimensions
    rows = fread(fid1,1,'int32');
    cols = fread(fid1,1,'int32');

    % Read the data
    images = fread(fid1,inf,'unsigned char');
    labels = fread(fid2,inf,'unsigned char');

    % Close the files
    fclose(fid1);
    fclose(fid2);

    % Reshape the image data
    images = reshape(images,cols,rows,numImages);
    images = permute(images,[2 1 3]);

    % Convert the labels to double
    labels = double(labels);
end % === END loadMNIST ===================================================
close all; clear vars;
% Instructions on how to run code: this file just needs to be in the same folder as the MNIST ubyte files
% Instructions on how to interpret result: The command window will show
% the accuracy and the number of incorrect labels

% 1. Load MNIST data sets
    [trainImages,trainLabels] = loadMNIST('train-images-idx3-ubyte','train-labels-idx1-ubyte');
    [testImages,testLabels] = loadMNIST('t10k-images-idx3-ubyte','t10k-labels-idx1-ubyte');

% 2. Reduce the data sets. Look only at the zeros and ones to get started.

    % Find indices of 0 and 1 digits.
        idx = ((trainLabels == 0) | (trainLabels == 1));
        idxTest = ((testLabels == 0) | (testLabels == 1));
        
    % Reduce the data set. Filter images and labels:
        binaryTrainImages = trainImages(:,:,idx);
        binaryTrainLabels = trainLabels(idx);
        binaryTestImages = testImages(:,:,idxTest);
        binaryTestLabels = testLabels(idxTest);

    % in order to avoids hard-coding numbers to possibly use with other
    % data sets in the future
        numPixels = size(binaryTrainImages,1)*size(binaryTrainImages,2);
        numTrainImages = size(binaryTrainImages,3);
        numTestImages = size(binaryTestImages,3);

    % Augment the data with ones
        x = reshape(binaryTrainImages(:,:,:), numPixels, numTrainImages); % first we transform the data into a matrix where each column corresponds to an image
        x = [ones(1,numTrainImages); x]; % this adds a row of ones along the top of the matrix, which adds a 1 at the beginnining of each image vector
        xT = reshape(binaryTestImages(:,:,:), numPixels, numTestImages); % same to test stuff
        xT = [ones(1,numTestImages); xT];
    

% 3. gradient descent

    maxIters = 100;
    beta = randn(1,numPixels + 1); % our initial guess, \beta_0
    %fprintf('Initial Guess:'); 
    %display(beta); thought about displaying the initial beta
    % to see which betas are 'better' at getting more accurate results but
    % each beta is a huuuge vector so it didnt really enlighten me when i
    % had this uncommented
    
    alpha = 0.01; % learning rate// could be optimized better//get smaller
    
    summandMatrix = zeros(numTrainImages, numPixels + 1); % makes an empty matrix for storing the things we are going to add
    
    for k=1:maxIters % LOOP 1: computes the gradient of the cost function and updates beta
        for i=1:numTrainImages % LOOP 2: computes each summand in the gradient calculation
            h_beta = 1/(1+exp(-beta*x(:,i)));
            insideBrackets = h_beta - binaryTrainLabels(i);
            summand = insideBrackets*x(:,i); 
            summandMatrix(i,:) = summand;
        end
        grad = (1/numTrainImages)*sum(summandMatrix); % update grad
        beta = beta - alpha*grad; % update beta
    end



% 4. display the accuracy

    r = zeros(1,numTestImages); % empty vector for results
    
    % creates results vector

    for i=1:numTestImages
        h_beta = 1/(1+exp(-beta*xT(:,i)));
        if h_beta >= 0.5
            r(i)=1;
        end
    end
    
    % computing accuracy
        s=0;

        f=0;
        
        for i = 1:numTestImages
            if r(i)==binaryTestLabels(i)
                s=s+1;
            else 
                f=f+1;
            end
        end
        
        accuracy = s/numTestImages;
       
        display(accuracy);

        fprintf('Number of incorrect labels:');

        display(f*1);


% Part 2 - let's see which ones got mislabeled

    mislabeled = zeros(1,f); % initilize to store indices of mislabeled data

    m=1;

    for i = 1:numTestImages  % find the bad ones
        if r(i)~=binaryTestLabels(i)
            mislabeled(m)=i;
            m=m+1;
        end
    end
   
    % creating the image:
    % set the number of rows and columns of the figure, to make
    % sure all the images will fit 
        col = ceil(sqrt(f));
        if (floor(sqrt(f))*ceil(sqrt(f))>=f)
            p = floor(sqrt(f));
        else 
            p = ceil(sqrt(f));
        end
        
        figure;

        for k = 1:f
            n=mislabeled(k);
            subplot(p,col,k);
            pcolor(flipud(binaryTestImages(:,:,n)));
            title(num2str(binaryTestLabels(n)));
        end

        colormap gray

        sgtitle('Mislabeled Data');

% ml_MNIST_display loadMNIST function

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
end
% === END loadMNIST =================
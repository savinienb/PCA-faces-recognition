function [transform_out] = computeLMStransform(F, maxiteration, errormin)
%Ideal feature coordinates
Fp = [13 20 ; 50 20 ; 34 34 ; 16 50 ; 48 50];

%Put F in homogeneous coordinates for applying transforms easily
F=[F ones(size(F, 1),1)];

%Initialize transform_out
transform_out = eye(3);

%Prepare iteration variables
iteration=0;
error=errormin+1;
F_memory=F;
while ((maxiteration>iteration) && (errormin<error))
    iteration=iteration+1;
    
    %Calculate the SVD
    [U, S, D]=svd(F'*F); 
    %apply the Least Mean Square formula with the SVD to speed up the calculation
    transform=D*(S^(-1))*U'*(F'*Fp); 
    
    %Build matrix for applying transform as multiplication
    transform = [transform(1:2, :)', transform(3,:)'; 0, 0, 1];
    F = (transform*F')'; 
    
    % Multiply both transforms for output
    transform_out = transform * transform_out;

    % Calculate the error
    error=sum(sum(abs(F_memory-F)));
    F_memory=F;
end

end
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests



file=`find ./student-submission/ListExamples.java 2>/dev/null`

if [[ ! -f $file ]] 
then
    echo "ListExamples.java not found. Check for spelling errors and file structure."
    exit 1
fi

cp $file grading-area
cp TestListExamples.java grading-area
cp lib/* grading-area

cd grading-area

javac -cp ".;hamcrest-core-1.3.jar;junit-4.13.2.jar" *.java 2>/dev/null

if [[ $? != 0 ]]
then 
    echo "Code could not compile properly. Try again."
    exit 1
fi

java -cp ".;junit-4.13.2.jar;hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > test_results.txt

results=`grep "Tests run:" test_results.txt`

if [[ $results == *"Failure"* ]]
then 
    echo "Not all tests passed. Try Again."
    exit 1
else 
    echo "All tests passed. Good job!"
    exit 0
fi
pipeline {
  agent any

  // Trigger this pipeline on GitHub push events
  triggers { githubPush() }

  options {
    // keep console output a bit tidier
    timestamps()
    ansiColor('xterm')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build / Run Script') {
      steps {
        sh './hello.sh | tee output.txt'
      }
    }

    stage('Archive Artifacts') {
      steps {
        archiveArtifacts artifacts: 'output.txt', fingerprint: true
      }
    }
  }

  post {
    success {
      emailext(
        to: 'praveen.m@terzocloud.com',
        subject: "✅ SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
        body: """<p>Build succeeded for <b>${env.JOB_NAME}</b> #${env.BUILD_NUMBER}.</p>
<p>Branch: ${env.BRANCH_NAME}</p>
<p>Artifacts: output.txt</p>
<p><a href="${env.BUILD_URL}console">Console log</a> | <a href="${env.BUILD_URL}artifact/output.txt">output.txt</a></p>""",
        mimeType: 'text/html',
        attachLog: true
      )
    }
    failure {
      emailext(
        to: 'praveen.m@terzocloud.com',
        subject: "❌ FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
        body: """<p>Build failed for <b>${env.JOB_NAME}</b> #${env.BUILD_NUMBER}.</p>
<p>Branch: ${env.BRANCH_NAME}</p>
<p><a href="${env.BUILD_URL}console">Console log</a></p>""",
        mimeType: 'text/html',
        attachLog: true
      )
    }
  }
}

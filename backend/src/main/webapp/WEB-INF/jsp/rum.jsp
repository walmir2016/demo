<script
        src="https://www.datadoghq-browser-agent.com/datadog-rum-v3.js"
        type="text/javascript">
</script>
<script>
    window.DD_RUM && window.DD_RUM.init({
        applicationId: '164ee480-7db3-4af6-aeb3-6ea32c943fc4',
        clientToken: 'pub6e9eb276785ea86bbe572db080df09f2',
        site: 'datadoghq.com',
        service:'demo',
        // Specify a version number to identify the deployed version of your application in Datadog
        // version: '1.0.0',
        sampleRate: 100,
        trackInteractions: true,
        defaultPrivacyLevel: 'mask-user-input'
    });

    window.DD_RUM &&
    window.DD_RUM.startSessionReplayRecording();
</script>
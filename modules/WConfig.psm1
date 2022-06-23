class Diashow
{
    [int]$interval
    [Boolean]$random
    [Boolean]$onBattery

    Diashow([int]$interval, [Boolean]$random, [Boolean]$onBattery)
    {
        $this.interval = [int]$interval;
        $this.random = [Boolean]$random;
        $this.onBattery = [Boolean]$onBattery;
    }

}
class Images
{
    [int]$interval;
    [int]$imageCount;

    Images([int]$interval, [int]$count)
    {
        $this.interval = $interval;
        $this.imageCount = $count;
    }
}
class WConfig
{
    [Diashow]$diashow
    [Images]$images
    [Xml]$conf
    $rootPath

    WConfig()
    {
    }

    init($rootPath)
    {
        $this.rootPath = $rootPath;
        $this.conf = Get-Content -Path "$rootPath/config/config.xml"
        $this.diashow = [Diashow]::new($this.conf.configuration.diashow.interval, $this.conf.configuration.diashow.random, $this.conf.configuration.diashow.onBattery)
        $this.images = [Images]::new($this.conf.configuration.images.interval, $this.conf.configuration.images.count)
    }

    save()
    {
        $this.conf.configuration.diashow.interval = [String]$this.diashow.interval
        $this.conf.configuration.diashow.random = [String]$this.diashow.random
        $this.conf.configuration.diashow.onbattery = [String]$this.diashow.onBattery
        $this.conf.configuration.images.interval = [String]$this.images.interval
        $this.conf.configuration.images.count = [String]$this.images.imageCount
        $this.conf.Save($this.rootPath + "/config/config.xml")
    }
}
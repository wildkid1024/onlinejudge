<script src="https://cdn.ckeditor.com/ckeditor5/10.0.0/classic/ckeditor.js" xmlns="http://www.w3.org/1999/html"></script>
<div class="margin-15">
    <div >
        <h4>Create News</h4>
        <form method="POST" class="table">
            <label >Title: </label></br><input type="text" name="title" class="form-control"><br/><br/>
            <label>Content: <br/></label><textarea name="content" id="editor"></textarea><br/><br/>

            <script>
                ClassicEditor
                        .create( document.querySelector( '#editor' ) )
                        .catch( error => {
                            console.error( error );
                        } );
            </script>
            <button type="submit" class="btn  btn-primary">添加</button>
            <button type="reset" class="btn  btn-danger">重置</button>
        </form>
    </div>
    <br><br>
</div>
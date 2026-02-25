<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void

{

    Schema::create('posts', function (Blueprint $table) {

        $table->uuid('id')->primary();

        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');

        $table->text('content');

        $table->string('photo_url')->nullable();

        $table->string('privacy', 20)->default('friends');

        $table->foreignUuid('club_id')->nullable()->constrained()->onDelete('cascade');

        $table->timestamps();

    });

}



public function down(): void

{

    Schema::dropIfExists('posts');

}
};
